From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/1] vhost: add vhost_blk driver
Date: Tue, 6 Nov 2018 22:41:07 +0100
Message-ID: <b547d195-4b4a-1b1d-8219-22a6a1b3b21a__49485.6890327812$1541540361$gmane$org@redhat.com>
References: <20181102182123.29420-1-v.mayatskih@gmail.com>
	<6a7f1668-bf2d-0caa-2efd-c8fab5f1db24@redhat.com>
	<CAGF4SLg6+nt+zV4haXys4Wz2dWPDyx7xHXuA+h01NcQ94j0E1A@mail.gmail.com>
	<57eefa62-7e66-786d-441c-5dd6b0d451a5@redhat.com>
	<20181106071349.GA5526@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20181106071349.GA5526@infradead.org>
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
To: Christoph Hellwig <hch@infradead.org>, Jason Wang <jasowang@redhat.com>
Cc: Vitaly Mayatskih <v.mayatskih@gmail.com>, kvm@vger.kernel.org, "Michael S . Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, stefanha@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/11/2018 08:13, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018 at 10:45:08AM +0800, Jason Wang wrote:
>>> Storage industry is shifting away from SCSI, which has a scaling
>>> problem.
>>
>> Know little about storage. For scaling, do you mean SCSI protocol itself? If
>> not, it's probably not a real issue for virtio-scsi itself.
> 
> The above is utter bullshit.  There is a big NVMe hype, but it is not
> because "SCSI has a scaling problem", but because the industry can sell
> a new thing, and the standardization body seems easier to work with.

In the case of Linux, there is indeed some performance to be gained by
skipping the SCSI layer in the guest and to a lesser extent in QEMU,
which is why virtio-blk is still in use.  But there's no scaling
problem, it's just extra constant overhead.

Paolo
