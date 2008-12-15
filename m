From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] AF_VMCHANNEL address family for guest<->host
	communication.
Date: Sun, 14 Dec 2008 22:44:36 -0800 (PST)
Message-ID: <20081214.224436.55256593.davem__20466.3351447836$1229323598$gmane$org@davemloft.net>
References: <20081214115054.4066.14557.stgit@dhcp-1-237.tlv.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081214115054.4066.14557.stgit@dhcp-1-237.tlv.redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: gleb@redhat.com
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Gleb Natapov <gleb@redhat.com>
Date: Sun, 14 Dec 2008 13:50:55 +0200

> It is undesirable to use TCP/IP for this purpose since network
> connectivity may not exist between host and guest and if it exists the
> traffic can be not routable between host and guest for security reasons
> or TCP/IP traffic can be firewalled (by mistake) by unsuspecting VM user.

I don't really accept this argument, sorry.

If you can't use TCP because it might be security protected or
misconfigured, adding this new stream protocol thing is not one
bit better.  It doesn't make any sense at all.

Also, if TCP could be "misconfigured" this new thing could just as
easily be screwed up too.  And I wouldn't be surprised to see a whole
bunch of SELINUX and netfilter features proposed later for this and
then we're back to square one.

You guys really need to rethink this.  Either a stream protocol is a
workable solution to your problem, or it isn't.

And don't bring up any "virtualization is special because..."
arguments into your reply because virtualization has nothing to do
with my objections stated above.
