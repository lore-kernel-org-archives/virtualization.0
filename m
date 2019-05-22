From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: Re: custom virt-io support (in user-mode-linux)
Date: Wed, 22 May 2019 15:00:32 +0100
Message-ID: <f21ae7ac-ae56-71e6-cebd-f97c8912f5e1__14048.7530896038$1563994797$gmane$org@cambridgegreys.com>
References: <0952696452f5ff4e38d2417029243fc60efa33d6.camel@sipsolutions.net>
	<ddeee710-d546-ff05-5c53-991a7d807067@kot-begemot.co.uk>
	<8b30e5cea2692d62fd7f486fc98effdb589a1412.camel@sipsolutions.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <8b30e5cea2692d62fd7f486fc98effdb589a1412.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org



On 22/05/2019 14:46, Johannes Berg wrote:
> Hi Anton,
> 
>>> I'm thinking about adding virt-io support to UML, but the tricky part is
>>> that while I want to use the virt-io basics (because it's a nice
>>> interface from the 'inside'), I don't actually want the stock drivers
>>> that are part of the kernel now (like virtio-net etc.) but rather
>>> something that integrates with wifi (probably building on hwsim).
> 
>> I have looked at using virtio semantics in UML in the past around the
>> point when I wanted to make the recvmmsg/sendmmsg vector drivers common
>> in UML and QEMU. It is certainly possible,
>>
>> I went for the native approach at the end though.
> 
> Hmm. I'm not sure what you mean by either :-)
> 
> Is there any commonality between the vector drivers? 

I was looking purely from a network driver perspective.

I had two options - either do a direct read/write as it does today or 
implement the ring/king semantics and read/write from that.

I decided to not bother with the latter and read/write directly from/to 
skbs.

> I can't see how
> that'd work without a bus abstraction (like virtio) in qemu? I mean, the
> kernel driver just calls uml_vector_sendmmsg(), which I'd say belongs
> more to the 'outside world', but that can't really be done in qemu?
> 
> Ok, I guess then I see what you mean by 'native' though.
> 
> Similarly, of course, I can implement arbitrary virt-io devices - just
> the kernel side doesn't call a function like uml_vector_sendmmsg()
> directly, but instead the virt-io model, and the model calls the
> function, which essentially is the same just with a (convenient)
> abstraction layer.
> 
> But this leaves the fundamental fact the model code ("vector_user.c" or
> a similar "virtio_user.c") is still part of the build.
> 
> I guess what I'm thinking is have something like "virtio_user_rpc.c"
> that uses some appropriate RPC to interact with the real model. IOW,
> rather than having all the model-specific logic actually be here (like
> vector_user.c actually knows how to send network packets over a real
> socket fd), try to call out to some RPC that contains the real model.
> 
> Now that I thought about it further, I guess my question boils down to
> "did anyone ever think about doing RPC for Virt-IO instead of putting
> the entire device model into the hypervisor/emulator/...".

Virtio in general no. UML specifically - yes. I have thought of mapping 
out all key device calls to RPCs for a few applications. The issue is 
that it is fairly difficult to make all of this function cleanly without 
blocking in strange places.

You may probably want to look at the UML UBD driver. That is an example 
of moving out all processing to an external thread and talking to it via 
a request/response API. While it still expects shared memory and needs 
access to UML address space the model should be more amenable to 
replacing various calls with RPCs as you have now left the rest of the 
kernel to run while you are processing the RPC. It also provides you 
with RPC completion interrupts, etc as a side effect.

So you basically have UML -> Thread -> RPCs -> Model?

> 
> johannes
> 
> 
> _______________________________________________
> linux-um mailing list
> linux-um@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-um
> 

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/
