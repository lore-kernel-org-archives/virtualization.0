From: john cooper <john.cooper@redhat.com>
Subject: Re: [PATCH 1/4] virtio_blk: deprecate the 1024-byte ID field.
Date: Wed, 07 Oct 2009 01:48:29 -0400
Message-ID: <4ACC2BAD.8010901@redhat.com>
References: <200909300248.09630.rusty@rustcorp.com.au>
	<200909300941.24736.borntraeger@de.ibm.com>
	<4ACA1CBC.8020402@redhat.com>
	<200910061951.47231.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200910061951.47231.rusty@rustcorp.com.au>
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
Cc: john.cooper@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> Also, I've been convinced to just hand over the 20 byte serial number
> since we're revisiting this.  It's simple, and there's no clear consensus.

I'm fine with this approach as it is where
I originally started with this Sisyphus Patch.
My bias toward pressing the ATA identify
interface into service here was just to reuse
an existing interface and make life easier
from the perspective of the guest. 

On the subject of retrieving the S/N alone, this
is the form of the simplistic ioctl originally
used to do so:

    unsigned char sn[80];
      :
    sn[0] = sizeof(sn);
    ioctl(fd, VBLK_GET_SN, &sn);

-john

-- 
john.cooper@redhat.com
