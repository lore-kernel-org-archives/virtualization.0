From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 1/2] virtio-balloon: tweak config_changed implementation
Date: Thu, 03 Jan 2019 18:31:41 +0800
Message-ID: <5C2DE48D.4090105__31536.0254761346$1546511056$gmane$org@intel.com>
References: <1546493462-32244-1-git-send-email-wei.w.wang@intel.com>
	<1546493462-32244-2-git-send-email-wei.w.wang@intel.com>
	<20190103104018.33eeaa29.cohuck@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20190103104018.33eeaa29.cohuck@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Cornelia Huck <cohuck@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, pasic@linux.ibm.com, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 01/03/2019 05:40 PM, Cornelia Huck wrote:
> On Thu,  3 Jan 2019 13:31:01 +0800
> Wei Wang <wei.w.wang@intel.com> wrote:
>
>> virtio-ccw has deadlock issues with reading config registers inside the
> s/config registers/the config space/ ?

Sounds good.

>
>> interrupt context, so we tweak the virtballoon_changed implementation
>> by moving the config read operations into the related workqueue contexts.
> Also credit Christian with a Reported-by:?

Yes, definitely. Sorry for missing that.

Best,
Wei
