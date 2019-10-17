From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH RFC 2/3] usb, kcov: collect coverage from hub_event
Date: Thu, 17 Oct 2019 11:19:43 -0700
Message-ID: <20191017181943.GC1094415__10958.9758839988$1571336395$gmane$org@kroah.com>
References: <cover.1571333592.git.andreyknvl@google.com>
	<1b30d1c9e7f86c25425c5ee53d7facede289608e.1571333592.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1b30d1c9e7f86c25425c5ee53d7facede289608e.1571333592.git.andreyknvl@google.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrey Konovalov <andreyknvl@google.com>
Cc: Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Elena Reshetova <elena.reshetova@intel.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 17, 2019 at 07:44:14PM +0200, Andrey Konovalov wrote:
> This patch adds kcov_remote_start/kcov_remote_stop annotations to the
> hub_event function, which is responsible for processing events on USB
> buses, in particular events that happen during USB device enumeration.
> Each USB bus gets a unique id, which can be used to attach a kcov device
> to a particular USB bus for coverage collection.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/usb/core/hub.c    | 4 ++++
>  include/linux/kcov.h      | 1 +
>  include/uapi/linux/kcov.h | 7 +++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/drivers/usb/core/hub.c b/drivers/usb/core/hub.c
> index 236313f41f4a..03a40e41b099 100644
> --- a/drivers/usb/core/hub.c
> +++ b/drivers/usb/core/hub.c
> @@ -5374,6 +5374,8 @@ static void hub_event(struct work_struct *work)
>  	hub_dev = hub->intfdev;
>  	intf = to_usb_interface(hub_dev);
>  
> +	kcov_remote_start(kcov_remote_handle_usb(hdev->bus->busnum));
> +
>  	dev_dbg(hub_dev, "state %d ports %d chg %04x evt %04x\n",
>  			hdev->state, hdev->maxchild,
>  			/* NOTE: expects max 15 ports... */
> @@ -5480,6 +5482,8 @@ static void hub_event(struct work_struct *work)
>  	/* Balance the stuff in kick_hub_wq() and allow autosuspend */
>  	usb_autopm_put_interface(intf);
>  	kref_put(&hub->kref, hub_release);
> +
> +	kcov_remote_stop();
>  }
>  
>  static const struct usb_device_id hub_id_table[] = {
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index 702672d98d35..38a47e0b67c2 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -30,6 +30,7 @@ void kcov_task_exit(struct task_struct *t);
>  /*
>   * Reserved handle ranges:
>   * 0000000000000000 - 0000ffffffffffff : common handles
> + * 0001000000000000 - 0001ffffffffffff : USB subsystem handles

So how many bits are you going to have for any in-kernel tasks?  Aren't
you going to run out quickly?


>   */
>  void kcov_remote_start(u64 handle);
>  void kcov_remote_stop(void);
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index 46f78f716ca9..45c9ae59cebc 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -43,4 +43,11 @@ enum {
>  #define KCOV_CMP_SIZE(n)        ((n) << 1)
>  #define KCOV_CMP_MASK           KCOV_CMP_SIZE(3)
>  
> +#define KCOV_REMOTE_HANDLE_USB  0x0001000000000000ull
> +
> +static inline __u64 kcov_remote_handle_usb(unsigned int bus)
> +{
> +	return KCOV_REMOTE_HANDLE_USB + (__u64)bus;
> +}

Why is this function in a uapi .h file?  What userspace code would call
this?

thanks,

greg k-h
