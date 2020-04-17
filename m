From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V2] vhost: do not enable VHOST_MENU by default
Date: Fri, 17 Apr 2020 17:48:20 +0800
Message-ID: <71b98c3b-1a38-b9aa-149c-f48c92a77448@redhat.com>
References: <20200416185426-mutt-send-email-mst@kernel.org>
 <b7e2deb7-cb64-b625-aeb4-760c7b28c0c8@redhat.com>
 <20200417022929-mutt-send-email-mst@kernel.org>
 <4274625d-6feb-81b6-5b0a-695229e7c33d@redhat.com>
 <20200417042912-mutt-send-email-mst@kernel.org>
 <fdb555a6-4b8d-15b6-0849-3fe0e0786038@redhat.com>
 <20200417044230-mutt-send-email-mst@kernel.org>
 <73843240-3040-655d-baa9-683341ed4786@redhat.com>
 <20200417050029-mutt-send-email-mst@kernel.org>
 <ce8a18e5-3c74-73cc-57c5-10c40af838a3@redhat.com>
 <20200417053803-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20200417053803-mutt-send-email-mst@kernel.org>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, geert@linux-m68k.org, tsbogend@alpha.franken.de, benh@kernel.crashing.org, paulus@samba.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com, Michael Ellerman <mpe@ellerman.id.au>
List-Id: virtualization@lists.linuxfoundation.org


On 2020/4/17 =E4=B8=8B=E5=8D=885:38, Michael S. Tsirkin wrote:
> On Fri, Apr 17, 2020 at 05:33:56PM +0800, Jason Wang wrote:
>> On 2020/4/17 =E4=B8=8B=E5=8D=885:01, Michael S. Tsirkin wrote:
>>>> There could be some misunderstanding here. I thought it's somehow si=
milar: a
>>>> CONFIG_VHOST_MENU=3Dy will be left in the defconfigs even if CONFIG_=
VHOST is
>>>> not set.
>>>>
>>>> Thanks
>>>>
>>> BTW do entries with no prompt actually appear in defconfig?
>>>
>> Yes. I can see CONFIG_VHOST_DPN=3Dy after make ARCH=3Dm68k defconfig
> You see it in .config right? So that's harmless right?


Yes.

Thanks
