From: Frans Pop <elendil@planet.nl>
Subject: Re: Bug on barriers for virtio_blk device - end_request: I/O error,
	dev vda, sector 0
Date: Wed, 14 Oct 2009 22:32:12 +0200
Message-ID: <200910142232.14837.elendil__46762.2377248064$1255552571$gmane$org@planet.nl>
References: <4AD5DC1D.9070002@navynet.it>
	<4AD5DC1D.9070002@navynet.it>=?utf-8?q?=0A1_2?=
	<4AD62690.9080408@navynet.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-reply-To: <4AD62690.9080408@navynet.it>
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
To: Massimo Cetra <mcetra@navynet.it>
Cc: Mark McLoughlin <markmc@redhat.com>, Neil Brown <neilb@suse.de>, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, dm-devel <dm-devel@redhat.com>, Mikulas Patocka <mpatocka@redhat.com>, Alasdair G Kergon <agk@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

Added CCs for the author of and people CCed on the patch.

The patch has been submitted twice (6 Aug, 3 Sept), the first time there 
was one concern voiced which seems to have been addressed in replies. The 
second time there were no reactions.

The patch seems to work for Massimo...

Massimo Cetra wrote:
> Massimo Cetra ha scritto:
>> Hello all,
>>
>> i ended up with some thiusands of errors after upgrading to 2.6.31.2
>> like this one:
>>
>> end_request: I/O error, dev vda, sector 0
>> end_request: I/O error, dev vda, sector 0
>> end_request: I/O error, dev vda, sector 0
>> end_request: I/O error, dev vda, sector 0
>>
>> I am using ocfs2 on top of drbd on top of LVM in a KVM guest that uses
>> virtio_blk.
>>
>> The bug is already known, see here:
>> https://bugzilla.redhat.com/show_bug.cgi?id=514901
>>
>> A patch exists and the problem has already been submitted here in the
>> list.
>> See here: http://lkml.org/lkml/2009/8/6/153
>>
>> That fix is not in 2.6.31 nor in 2.6.32-RCX
>>
>> Could you please consider pulling it and adding this fix for inclusion
>> in 2.6.31.$next and also to mainline?
>>
>> Thanks.
>
> No one listening here ?

It helps if you CC the people who maintain the relevant code.

> This makes virtio_blk on LVM unusable.

Cheers,
FJP
