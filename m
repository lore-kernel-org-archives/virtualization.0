From: Herbert Xu <herbert@gondor.apana.org.au>
Subject: [0/6] [NET]: virtio SG/TSO patches
Date: Fri, 18 Apr 2008 11:12:57 +0800
Message-ID: <20080418031257.GA17993@gondor.apana.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Hi:

Here are the patches I used for testing KVM with virtio-net using
TSO.  There are three patches for the tun device which are basically
Rusty's patches with the mmap turned into copying (for correctness).
Two patches are for the virtio-net frontend, one required to support
receiving SG/TSO, and the other useful for testing SG per se.  The
other patch is to the KVM backend to make all this work.  It isn't
the prettiest or the smartest solution but it was the easiest :)

Cheers,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
