From: Hannes Reinecke <hare@suse.de>
Subject: Re: DEFINE_IDA causing memory leaks? (was Re: [PATCH 1/2] virtio: fix
	memory leak of virtio ida cache layers)
Date: Thu, 17 Sep 2015 08:51:54 +0200
Message-ID: <55FA630A.4020707__20323.4737775803$1442472738$gmane$org@suse.de>
References: <1442449758-14594-1-git-send-email-s-anna@ti.com>
	<1442449758-14594-2-git-send-email-s-anna@ti.com>
	<20150917082425-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150917082425-mutt-send-email-mst@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>, Suman Anna <s-anna@ti.com>
Cc: open-iscsi@googlegroups.com, JBottomley@Odin.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/17/2015 07:33 AM, Michael S. Tsirkin wrote:
> On Wed, Sep 16, 2015 at 07:29:17PM -0500, Suman Anna wrote:
>> The virtio core uses a static ida named virtio_index_ida for
>> assigning index numbers to virtio devices during registration.
>> The ida core may allocate some internal idr cache layers and
>> an ida bitmap upon any ida allocation, and all these layers are
>> truely freed only upon the ida destruction. The virtio_index_ida
>> is not destroyed at present, leading to a memory leak when using
>> the virtio core as a module and atleast one virtio device is
>> registered and unregistered.
>>
>> Fix this by invoking ida_destroy() in the virtio core module
>> exit.
>>
>> Cc: "Michael S. Tsirkin" <mst@redhat.com>
>> Signed-off-by: Suman Anna <s-anna@ti.com>
> =

> Interesting.
> Will the same apply to e.g. sd_index_ida in drivers/scsi/sd.c
> or iscsi_sess_ida in drivers/scsi/scsi_transport_iscsi.c?
> =

> If no, why not?
> =

> One doesn't generally expect to have to free global variables.
> Maybe we should forbid DEFINE_IDA in modules?
> =

> James, could you comment on this please?
> =

Well, looking at the code 'ida_destroy' only need to be called
if you want/need to do a general cleanup.
It shouldn't be required if you do correct reference counting
on your objects, and call idr_remove() on each of them.

Unless I'm misreading something.

Seems like a topic for KS; Johannes had a larger patchset recently to
clean up idr, which run into very much the same issues.

Cheers,

Hannes

-- =

Dr. Hannes Reinecke		      zSeries & Storage
hare@suse.de			      +49 911 74053 688
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg
GF: J. Hawn, J. Guild, F. Imend=F6rffer, HRB 16746 (AG N=FCrnberg)
