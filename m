From: Bart Van Assche <Bart.VanAssche@sandisk.com>
Subject: Re: [PATCH] linux/types.h: enable endian checks for all sparse builds
Date: Thu, 8 Dec 2016 06:38:11 +0000
Message-ID: <BLUPR02MB168304F8FBA50C916A6A4E6081840__4211.47799720547$1481205560$gmane$org@BLUPR02MB1683.namprd02.prod.outlook.com>
References: <1481164052-28036-1-git-send-email-mst@redhat.com>
	<BLUPR02MB168374E98A6C86E43DF0BCFE81840@BLUPR02MB1683.namprd02.prod.outlook.com>
	<20161208075152-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Neil Armstrong <narmstrong@baylibre.com>, David Airlie <airlied@linux.ie>, "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "James
	E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Herbert Xu <herbert@gondor.apana.org.au>, "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>, Christoph Hellwig <hch@infradead.org>, "v9fs-developer@lists.sourceforge.net" <v9fs-developer@lists.sourceforge.net>, Asias He <asias@redhat.com>, Arnd Bergmann <arnd@arndb.de>, "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>, Jens Axboe <axboe@fb.com>, Michal Marek <mmarek@suse.com>, Stefan Hajnoczi <stef>
List-Id: virtualization@lists.linuxfoundation.org

On 12/07/16 21:54, Michael S. Tsirkin wrote:
> On Thu, Dec 08, 2016 at 05:21:47AM +0000, Bart Van Assche wrote:
>> Additionally, there are notable exceptions to the rule that most drivers
>> are endian-clean, e.g. drivers/scsi/qla2xxx. I would appreciate it if it
>> would remain possible to check such drivers with sparse without enabling
>> endianness checks. Have you considered to change #ifdef __CHECK_ENDIAN__
>> into e.g. #ifndef __DONT_CHECK_ENDIAN__?
>
> The right thing is probably just to fix these, isn't it?
> Until then, why not just ignore the warnings?

Neither option is realistic. With endian-checking enabled the qla2xxx 
driver triggers so many warnings that it becomes a real challenge to 
filter the non-endian warnings out manually:

$ for f in "" CF=-D__CHECK_ENDIAN__; do make M=drivers/scsi/qla2xxx C=2\
     $f | &grep -c ': warning:'; done
4
752

If you think it would be easy to fix the endian warnings triggered by 
the qla2xxx driver, you are welcome to try to fix these.

Bart.
