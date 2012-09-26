From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 0/2] virtio-mmio updates for 3.7
Date: Wed, 26 Sep 2012 09:40:48 +0930
Message-ID: <87mx0d3apj.fsf@rustcorp.com.au>
References: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
	<87d31bufkl.fsf@rustcorp.com.au> <1348571527.27071.37.camel@hornet>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1348571527.27071.37.camel@hornet>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Brian Foley <Brian.Foley@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

Pawel Moll <pawel.moll@arm.com> writes:

> On Tue, 2012-09-25 at 01:11 +0100, Rusty Russell wrote:
>> > Would you be so kind and consider getting those two small fixes into
>> > 3.7 merge? All credits go to Brian, all shame on me :-)
>> 
>> Should these also be cc'd to stable@kernel.org?
>
> I was thinking about it, but as the problem manifests itself mainly on
> architectures with large page size, the impact is limited.
>
> But if you think it's worth it, I will repost with Cc: stable.

I agree with you. But if it's not CC' stable, it's not for 3.7 either,
since at this late stage the rules are basically synonymous.

Cheers,
Rusty.
