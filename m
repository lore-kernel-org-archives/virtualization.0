From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] VMCI: Use BIT() macro for bit definitions
Date: Mon, 11 Mar 2019 15:38:56 -0700
Message-ID: <8e80e76d-1793-fc45-9f89-cf8e61dc4a16__20700.7393635408$1552343979$gmane$org@infradead.org>
References: <20190311220928.4560-1-vdasa@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190311220928.4560-1-vdasa@vmware.com>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Vishnu DASA <vdasa@vmware.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
Cc: Pv-drivers <Pv-drivers@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 3/11/19 3:09 PM, Vishnu DASA wrote:
> No functional changes, cleanup only.
> 
> Reviewed-by: Adit Ranadive <aditr@vmware.com>
> Reviewed-by: Jorgen Hansen <jhansen@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  include/linux/vmw_vmci_defs.h | 34 +++++++++++++++++-----------------
>  1 file changed, 17 insertions(+), 17 deletions(-)
> 

Now this header file needs to #include <linux/bitops.h>
or <linux/bits.h> for the BIT() macro.

Do the users of this header file build cleanly anyway?
Even if so, we prefer not to depend on implicit or accidental header
file inclusions that may change in the future.

> diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
> index eaa1e762bf06..007e28053da8 100644
> --- a/include/linux/vmw_vmci_defs.h
> +++ b/include/linux/vmw_vmci_defs.h
> @@ -33,27 +33,27 @@
>  #define VMCI_MAX_DEVICES 1
>  
>  /* Status register bits. */
> -#define VMCI_STATUS_INT_ON     0x1
> +#define VMCI_STATUS_INT_ON     BIT(0)
>  
>  /* Control register bits. */
> -#define VMCI_CONTROL_RESET        0x1
> -#define VMCI_CONTROL_INT_ENABLE   0x2
> -#define VMCI_CONTROL_INT_DISABLE  0x4
> +#define VMCI_CONTROL_RESET        BIT(0)
> +#define VMCI_CONTROL_INT_ENABLE   BIT(1)
> +#define VMCI_CONTROL_INT_DISABLE  BIT(2)
>  
>  /* Capabilities register bits. */
> -#define VMCI_CAPS_HYPERCALL     0x1
> -#define VMCI_CAPS_GUESTCALL     0x2
> -#define VMCI_CAPS_DATAGRAM      0x4
> -#define VMCI_CAPS_NOTIFICATIONS 0x8
> -#define VMCI_CAPS_PPN64         0x10
> +#define VMCI_CAPS_HYPERCALL     BIT(0)
> +#define VMCI_CAPS_GUESTCALL     BIT(1)
> +#define VMCI_CAPS_DATAGRAM      BIT(2)
> +#define VMCI_CAPS_NOTIFICATIONS BIT(3)
> +#define VMCI_CAPS_PPN64         BIT(4)
>  
>  /* Interrupt Cause register bits. */
> -#define VMCI_ICR_DATAGRAM      0x1
> -#define VMCI_ICR_NOTIFICATION  0x2
> +#define VMCI_ICR_DATAGRAM      BIT(0)
> +#define VMCI_ICR_NOTIFICATION  BIT(1)
>  
>  /* Interrupt Mask register bits. */
> -#define VMCI_IMR_DATAGRAM      0x1
> -#define VMCI_IMR_NOTIFICATION  0x2
> +#define VMCI_IMR_DATAGRAM      BIT(0)
> +#define VMCI_IMR_NOTIFICATION  BIT(1)
>  
>  /* Maximum MSI/MSI-X interrupt vectors in the device. */
>  #define VMCI_MAX_INTRS 2
> @@ -463,9 +463,9 @@ struct vmci_datagram {
>   * datagram callback is invoked in a delayed context (not interrupt context).
>   */
>  #define VMCI_FLAG_DG_NONE          0
> -#define VMCI_FLAG_WELLKNOWN_DG_HND 0x1
> -#define VMCI_FLAG_ANYCID_DG_HND    0x2
> -#define VMCI_FLAG_DG_DELAYED_CB    0x4
> +#define VMCI_FLAG_WELLKNOWN_DG_HND BIT(0)
> +#define VMCI_FLAG_ANYCID_DG_HND    BIT(1)
> +#define VMCI_FLAG_DG_DELAYED_CB    BIT(2)
>  
>  /*
>   * Maximum supported size of a VMCI datagram for routable datagrams.
> @@ -694,7 +694,7 @@ struct vmci_qp_detach_msg {
>  };
>  
>  /* VMCI Doorbell API. */
> -#define VMCI_FLAG_DELAYED_CB 0x01
> +#define VMCI_FLAG_DELAYED_CB BIT(0)
>  
>  typedef void (*vmci_callback) (void *client_data);
>  
> 


-- 
~Randy
