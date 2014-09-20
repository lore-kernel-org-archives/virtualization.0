From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH RFC 2/2] vhost: support urgent descriptors
Date: Sat, 20 Sep 2014 12:00:27 +0200
Message-ID: <541D503B.3070507@redhat.com>
References: <1404203661-7521-1-git-send-email-mst@redhat.com>	<1404203661-7521-2-git-send-email-mst@redhat.com>
	<541BD6E9.2010707@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <541BD6E9.2010707@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Il 19/09/2014 09:10, Jason Wang ha scritto:
>> >  
>> > -	if (!vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
>> > +	if (vq->urgent || !vhost_has_feature(vq, VIRTIO_RING_F_EVENT_IDX)) {
> So the urgent descriptor only work when event index was not enabled?
> This seems suboptimal, we may still want to benefit from event index
> even if urgent descriptor is used. Looks like we need return true here
> when vq->urgent is true?

Its ||, not &&.

Without event index, all descriptors are treated as urgent.

Paolo
