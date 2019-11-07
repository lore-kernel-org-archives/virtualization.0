From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH v3 2/3] usb, kcov: collect coverage from hub_event
Date: Thu, 7 Nov 2019 11:19:07 +0100
Message-ID: <20191107101907.GA1365996__11926.9780743466$1573121959$gmane$org@kroah.com>
References: <cover.1572366574.git.andreyknvl@google.com>
	<de4fe1c219db2d002d905dc1736e2a3bfa1db997.1572366574.git.andreyknvl@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <de4fe1c219db2d002d905dc1736e2a3bfa1db997.1572366574.git.andreyknvl@google.com>
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
Cc: Marco Elver <elver@google.com>, Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, virtualization@lists.linux-foundation.org, Alan Stern <stern@rowland.harvard.edu>, Elena Reshetova <elena.reshetova@intel.com>, Alexander Potapenko <glider@google.com>, Andrew Morton <akpm@linux-foundation.org>, Dmitry Vyukov <dvyukov@google.com>, David Windsor <dwindsor@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 29, 2019 at 05:32:28PM +0100, Andrey Konovalov wrote:
> This patch adds kcov_remote_start()/kcov_remote_stop() annotations to the
> hub_event() function, which is responsible for processing events on USB
> buses, in particular events that happen during USB device enumeration.
> Since hub_event() is run in a global background kernel thread (see
> Documentation/dev-tools/kcov.rst for details), each USB bus gets a unique
> global handle from the USB subsystem kcov handle range. As the result kcov
> can now be used to collect coverage from events that happen on a
> particular USB bus.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  drivers/usb/core/hub.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
