From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH RFC v6 08/20] dataplane: allow virtio-1 devices
Date: Tue, 20 Jan 2015 14:47:03 +0000
Message-ID: <CAJSP0QWApjA_WSb9AeWDrYX-F+qoTNKSPiWRgHDn_Ddg_qQFxQ@mail.gmail.com>
References: <1418304322-7546-1-git-send-email-cornelia.huck@de.ibm.com>
	<1418304322-7546-9-git-send-email-cornelia.huck@de.ibm.com>
	<20150120104331.GF17631@stefanha-thinkpad.redhat.com>
	<20150120135607.7b701bc3.cornelia.huck@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150120135607.7b701bc3.cornelia.huck@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Thomas Huth <thuth@linux.vnet.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Linux Virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Jan 20, 2015 at 12:56 PM, Cornelia Huck
<cornelia.huck@de.ibm.com> wrote:
> On Tue, 20 Jan 2015 10:43:31 +0000
> Stefan Hajnoczi <stefanha@gmail.com> wrote:
>> On Thu, Dec 11, 2014 at 02:25:10PM +0100, Cornelia Huck wrote:
>> > @@ -154,15 +157,18 @@ bool vring_should_notify(VirtIODevice *vdev, Vring *vring)
>> >  }
>> >
>> >
>> > -static int get_desc(Vring *vring, VirtQueueElement *elem,
>> > +static int get_desc(VirtIODevice *vdev, Vring *vring, VirtQueueElement *elem,
>> >                      struct vring_desc *desc)
>>
>> Since we copy in struct vring_desc anyway, it's cleaner to byteswap the
>> fields once instead of remembering to do it each time we need to access
>> a field.  The copy_in_vring_desc() function is one thing I prefer I
>> about my patch.
>
> Agreed, that makes the code cleaner.
>
> I've prepared a version of this patch using copy_in_vring_desc() and
> I'll post it when it survives some light testing on my side.

Cool, thanks for doing this!

Stefan
