From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC] virtio: Support releasing lock during kick
Date: Fri, 24 Jun 2011 10:16:57 +0100
Message-ID: <BANLkTimr00oKhSjSuxaJz9VHVZ5iwJ0qbg__45513.3157004186$1308907077$gmane$org@mail.gmail.com>
References: <1277328242-10685-1-git-send-email-stefanha@linux.vnet.ibm.com>
	<20110619071452.GA7930@redhat.com>
	<BANLkTi=fsSLNu2ybeMKvN7gtCDO5FDNfDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=fsSLNu2ybeMKvN7gtCDO5FDNfDA@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, Jun 20, 2011 at 4:27 PM, Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Sun, Jun 19, 2011 at 8:14 AM, Michael S. Tsirkin <mst@redhat.com> wrot=
e:
>> On Wed, Jun 23, 2010 at 10:24:02PM +0100, Stefan Hajnoczi wrote:
>>> The virtio block device holds a lock during I/O request processing.
>>> Kicking the virtqueue while the lock is held results in long lock hold
>>> times and increases contention for the lock.
>>>
>>> This patch modifies virtqueue_kick() to optionally release a lock while
>>> notifying the host. =A0Virtio block is modified to pass in its lock. =
=A0This
>>> allows other vcpus to queue I/O requests during the time spent servicing
>>> the virtqueue notify in the host.
>>>
>>> The virtqueue_kick() function is modified to know about locking because
>>> it changes the state of the virtqueue and should execute with the lock
>>> held (it would not be correct for virtio block to release the lock
>>> before calling virtqueue_kick()).
>>>
>>> Signed-off-by: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
>>
>> While the optimization makes sense, the API's pretty hairy IMHO.
>> Why don't we split the kick functionality instead?
>> E.g.
>> =A0 =A0 =A0 =A0/* Report whether host notification is necessary. */
>> =A0 =A0 =A0 =A0bool virtqueue_kick_prepare(struct virtqueue *vq)
>> =A0 =A0 =A0 =A0/* Can be done in parallel with add_buf/get_buf */
>> =A0 =A0 =A0 =A0void virtqueue_kick_notify(struct virtqueue *vq)
>
> This is a nice idea, it makes the code cleaner. =A0I am testing patches
> that implement this and after Khoa has measured the performance I will
> send them out.

Just an update that benchmarks are being run.  Will send out patches
and results as soon as they are in.

Stefan
