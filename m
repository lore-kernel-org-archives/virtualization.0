From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vhost: drop vring dependency on iotlb
Date: Fri, 3 Apr 2020 14:38:27 +0800
Message-ID: <f811f02e-5681-33c0-f970-f60c62ff0041@redhat.com>
References: <20200402144519.34194-1-mst@redhat.com>
 <44f9b9d3-3da2-fafe-aa45-edd574dc6484@redhat.com>
 <20200402122544-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20200402122544-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/3 =E4=B8=8A=E5=8D=8812:27, Michael S. Tsirkin wrote:
> On Thu, Apr 02, 2020 at 11:01:13PM +0800, Jason Wang wrote:
>> On 2020/4/2 =E4=B8=8B=E5=8D=8810:46, Michael S. Tsirkin wrote:
>>> vringh can now be built without IOTLB.
>>> Select IOTLB directly where it's used.
>>>
>>> Signed-off-by: Michael S. Tsirkin<mst@redhat.com>
>>> ---
>>>
>>> Applies on top of my vhost tree.
>>> Changes from v1:
>>> 	VDPA_SIM needs VHOST_IOTLB
>> It looks to me the patch is identical to v1.
>>
>> Thanks
> you are right. I squashed the description into
>      virtio/test: fix up after IOTLB changes
> take a look at it in the vhost tree.


Looks fine.

Thanks


>
