From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/2] virtio: hardware random device
Date: Fri, 16 May 2008 09:31:53 +0200
Message-ID: <200805160931.53875.borntraeger__47229.2855768048$1210923402$gmane$org@de.ibm.com>
References: <482C8595.5030509@garzik.org>
	<200805160943.08788.rusty@rustcorp.com.au>
	<200805161531.44725.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805161531.44725.rusty@rustcorp.com.au>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: LKML <linux-kernel@vger.kernel.org>, "H. Anvin" <hpa@zytor.com>, Herbert Xu <herbert@gondor.apana.org.au>, Jeff Garzik <jeff@garzik.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Freitag, 16. Mai 2008 schrieb Rusty Russell:
> virtio: An entropy device, as suggested by hpa.
> 
> Note that by itself, having a "hardware" random generator does very
> little: you should probably run "rngd" in your guest to feed this into
> the kernel entropy pool.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> ---
>  drivers/char/hw_random/Kconfig      |   10 ++
>  drivers/char/hw_random/Makefile     |    1 
>  drivers/char/hw_random/virtio-rng.c |  143 +++++++++++++++++++++++++++++++
>  include/linux/virtio_rng.h          |    8 ++
>  4 files changed, 162 insertions(+)

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
