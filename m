From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Virt RNG?
Date: Thu, 15 May 2008 20:53:19 +0100
Message-ID: <482C94AF.2010202@goop.org>
References: <482C8595.5030509@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <482C8595.5030509@garzik.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeff Garzik <jeff@garzik.org>
Cc: virtualization@lists.osdl.org, LKML <linux-kernel@vger.kernel.org>, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: virtualization@lists.linuxfoundation.org

Jeff Garzik wrote:
> Has anyone yet written a "hw" RNG module for virt, that reads the host's 
> random number pool?
>
> All this talk[1] about IRQF_SAMPLE_RANDOM in network drivers reminds me 
> that virt guest instances should be grabbing random numbers from the 
> host, especially if the host has a hardware RNG.

It was actually one of the first device types proposed for what would 
become virtio, but as far as I know there has been no work on such a 
device.  It certainly makes lots of sense.

    J
