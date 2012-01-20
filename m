From: Akinobu Mita <akinobu.mita@gmail.com>
Subject: Re: [PATCH] xen-blkfront: use bitmap_set() and bitmap_clear()
Date: Sat, 21 Jan 2012 00:41:56 +0900
Message-ID: <CAC5umyi9vuOh9Bx_HoB8ieXcVjZsisKOG6mCEM2ZGL7zXCrVTQ@mail.gmail.com>
References: <1327072528-8479-1-git-send-email-akinobu.mita@gmail.com>
	<1327072528-8479-4-git-send-email-akinobu.mita@gmail.com>
	<20120120152819.GA3959@phenom.dumpdata.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120120152819.GA3959@phenom.dumpdata.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: akpm@linux-foundation.org, xen-devel@lists.xensource.com, linux-kernel@vger.kernel.org, Jeremy Fitzhardinge Jeremy Fitzhardinge <jeremy@goop.org>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

2012/1/21 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>:
> On Sat, Jan 21, 2012 at 12:15:26AM +0900, Akinobu Mita wrote:
>> Use bitmap_set and bitmap_clear rather than modifying individual bits
>> in a memory region.
>>
>> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
>> Cc: Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>
>> Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>> Cc: xen-devel@lists.xensource.com
>> Cc: virtualization@lists.linux-foundation.org
>> ---
>> =A0drivers/block/xen-blkfront.c | =A0 =A07 +++----
>> =A01 files changed, 3 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
>> index 2f22874..619868d 100644
>> --- a/drivers/block/xen-blkfront.c
>> +++ b/drivers/block/xen-blkfront.c
>> @@ -43,6 +43,7 @@
>> =A0#include <linux/slab.h>
>> =A0#include <linux/mutex.h>
>> =A0#include <linux/scatterlist.h>
>> +#include <linux/bitmap.h>
>>
>> =A0#include <xen/xen.h>
>> =A0#include <xen/xenbus.h>
>> @@ -177,8 +178,7 @@ static int xlbd_reserve_minors(unsigned int minor, u=
nsigned int nr)
>>
>> =A0 =A0 =A0 spin_lock(&minor_lock);
>> =A0 =A0 =A0 if (find_next_bit(minors, end, minor) >=3D end) {
>> - =A0 =A0 =A0 =A0 =A0 =A0 for (; minor < end; ++minor)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __set_bit(minor, minors);
>> + =A0 =A0 =A0 =A0 =A0 =A0 bitmap_set(minors, minor, nr);
>
> Hm, I would have thought the last argument should have been 'end'?

'end' is the index of the last bit to clear.  But the last argument of
bitmap_clear() is the number of bits to clear.  So I think 'nr' is correct.

> Did you test this patch with a large amount of minors?

Sorry I didn't do runtime test.

>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D 0;
>> =A0 =A0 =A0 } else
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 rc =3D -EBUSY;
>> @@ -193,8 +193,7 @@ static void xlbd_release_minors(unsigned int minor, =
unsigned int nr)
>>
>> =A0 =A0 =A0 BUG_ON(end > nr_minors);
>> =A0 =A0 =A0 spin_lock(&minor_lock);
>> - =A0 =A0 for (; minor < end; ++minor)
>> - =A0 =A0 =A0 =A0 =A0 =A0 __clear_bit(minor, minors);
>> + =A0 =A0 bitmap_clear(minors, =A0minor, nr);
>
> Ditto.
>> =A0 =A0 =A0 spin_unlock(&minor_lock);
>> =A0}
>>
>> --
>> 1.7.4.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at =A0http://www.tux.org/lkml/
