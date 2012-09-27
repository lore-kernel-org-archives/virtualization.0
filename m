From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH 0/2] virtio-mmio updates for 3.7
Date: Thu, 27 Sep 2012 17:33:35 +0100
Message-ID: <1348763615.27071.55.camel@hornet>
References: <1348493622-26091-1-git-send-email-pawel.moll@arm.com>
	<87d31bufkl.fsf@rustcorp.com.au> <1348571527.27071.37.camel@hornet>
	<87mx0d3apj.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87mx0d3apj.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Brian Foley <Brian.Foley@arm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2012-09-26 at 01:10 +0100, Rusty Russell wrote:
> > I was thinking about it, but as the problem manifests itself mainly on
> > architectures with large page size, the impact is limited.
> >
> > But if you think it's worth it, I will repost with Cc: stable.
> 
> I agree with you. But if it's not CC' stable, it's not for 3.7 either,
> since at this late stage the rules are basically synonymous.

Ok, let's postpone it till 3.8 for now, than. If we find out that this
is a real problem I'll re-post it with Cc: stable around 3.7-rc2, 3.

Cheers!

Pawel
