From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: virtio: Add memory statistics reporting to the balloon driver (V3)
Date: Fri, 20 Nov 2009 10:23:30 +1030
Message-ID: <200911201023.30709.rusty__31631.246666848$1258674871$gmane$org@rustcorp.com.au>
References: <1258643169.3464.3.camel@aglitke> <1258643945.3464.5.camel@aglitke>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1258643945.3464.5.camel@aglitke>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Adam Litke <agl@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Anthony Liguori <aliguori@us.ibm.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 20 Nov 2009 01:49:05 am Adam Litke wrote:
> Rusty and Anthony,
> If I've addressed all outstanding issues, please consider this patch for
> inclusion.  Thanks.
> 
> Changes since V2:
>  - Increase stat field size to 64 bits
>  - Report all sizes in kb (not pages)

Hi Adam,

   Looks like we're very close.  A few minor things:

Why k?  Why not just do the simplest possible thing, and just report all
stats as straight numbers, now we have 64 bits.

>  - Drop anon_pages stat and fix endianness conversion

Please drop endianness conversion.

> +struct virtio_balloon_stat
> +{
> +	__le16 tag;
> +	__le64 val;
> +};

Let's not introduce padding as well; __attribute__((packed)) here please.

Thanks,
Rusty.
