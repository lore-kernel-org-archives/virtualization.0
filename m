From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH] linux/types.h: enable endian checks for all sparse builds
Date: Thu, 8 Dec 2016 05:21:47 +0000
Message-ID: <BLUPR02MB168374E98A6C86E43DF0BCFE81840__23029.9648283564$1481205553$gmane$org@BLUPR02MB1683.namprd02.prod.outlook.com>
References: <1481164052-28036-1-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@infradead.org>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, Asias He <asias@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Michal Marek <mmarek@suse.com>, Stefan Hajnoczi <stefanha@redhat.com>, Matt Mackall <mpm@sele>
List-Id: virtualization@lists.linuxfoundation.org

On 12/07/16 18:29, Michael S. Tsirkin wrote:
> By now, linux is mostly endian-clean. Enabling endian-ness
> checks for everyone produces about 200 new sparse warnings for me -
> less than 10% over the 2000 sparse warnings already there.
>
> Not a big deal, OTOH enabling this helps people notice
> they are introducing new bugs.
>
> So let's just drop __CHECK_ENDIAN__. Follow-up patches
> can drop distinction between __bitwise and __bitwise__.

Hello Michael,

This patch makes a whole bunch of ccflags-y += -D__CHECK_ENDIAN__ 
statements obsolete. Have you considered to remove these statements?

Additionally, there are notable exceptions to the rule that most drivers 
are endian-clean, e.g. drivers/scsi/qla2xxx. I would appreciate it if it 
would remain possible to check such drivers with sparse without enabling 
endianness checks. Have you considered to change #ifdef __CHECK_ENDIAN__ 
into e.g. #ifndef __DONT_CHECK_ENDIAN__?

Thanks,

Bart.
