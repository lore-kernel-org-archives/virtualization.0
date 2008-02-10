From: Anthony Liguori <anthony@codemonkey.ws>
Subject: Re: [kvm-devel] [PATCH] virtio_ring: make structure defines packed
Date: Sat, 09 Feb 2008 18:51:14 -0600
Message-ID: <47AE4A82.3030504__36462.4459682547$1202614656$gmane$org@codemonkey.ws>
References: <200802081401.21194.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200802081401.21194.borntraeger@de.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi Christian,

Christian Borntraeger wrote:
>  struct vring_used
>  {
>  	__u16 flags;
>  	__u16 idx;
> +	__u32 padding;
>  	struct vring_used_elem ring[];
> -};
> +} __attribute__ ((packed));
>   

This padding that you've put in is not something that would normally 
occur on x86.  I've checked with GCC on 32-bit and 64-bit and neither 
would include that padding.  Is that padding included on s390?

I don't think we can do this on x86 at this point as it changes the 
ABI.  FWIW, I agree with Arnd also that we should not explicitly pad 
structures that are naturally aligned anyway.

Regards,

Anthony Liguori


>  struct vring {
>  	unsigned int num;
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Microsoft
> Defy all challenges. Microsoft(R) Visual Studio 2008.
> http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
> _______________________________________________
> kvm-devel mailing list
> kvm-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/kvm-devel
>   
