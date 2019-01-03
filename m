From: Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v1 0/2] Virtio: fix some vq allocation issues
Date: Thu, 03 Jan 2019 14:18:22 +0800
Message-ID: <5C2DA92E.9090503__3440.058817114$1546495857$gmane$org@intel.com>
References: <1545963986-11280-1-git-send-email-wei.w.wang@intel.com>
	<c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <c6746307-fae5-7652-af8d-19f560fc31d9@de.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christian Borntraeger <borntraeger@de.ibm.com>, virtio-dev@lists.oasis-open.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com, cohuck@redhat.com
Cc: Halil Pasic <pasic@linux.ibm.com>, pbonzini@redhat.com, dgilbert@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 12/28/2018 03:57 PM, Christian Borntraeger wrote:
>
> On 28.12.2018 03:26, Wei Wang wrote:
>> Some vqs don't need to be allocated when the related feature bits are
>> disabled. Callers notice the vq allocation layer by setting the related
>> names[i] to be NULL.
>>
>> This patch series fixes the find_vqs implementations to handle this case.
> So the random crashes during boot are gone.
> What still does not work is actually using the balloon.
>
> So in the qemu monitor using lets say "balloon 1000"  will hang the guest.
> Seems to be a deadlock in the virtio-ccw code.  We seem to call the
> config code in the interrupt handler.

Please try with applying both this series and the "virtio-balloon: tweak 
config_changed"
series that I just sent.
This series fixes the ccw booting issue and that series tries to fix the 
ccw deadlock issue.

Best,
Wei
