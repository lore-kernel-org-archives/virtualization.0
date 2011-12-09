From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v3 REPOST] xen-netfront: delay gARP until backend
	switches to Connected
Date: Fri, 09 Dec 2011 13:45:14 -0500 (EST)
Message-ID: <20111209.134514.2071890208094978847.davem__5158.73742192543$1323456503$gmane$org@davemloft.net>
References: <1323430738-3798-1-git-send-email-lersek@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1323430738-3798-1-git-send-email-lersek@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: lersek@redhat.com
Cc: jeremy@goop.org, xen-devel@lists.xensource.com, ian.campbell@citrix.com, konrad.wilk@oracle.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: Laszlo Ersek <lersek@redhat.com>
Date: Fri,  9 Dec 2011 12:38:58 +0100

> These two together provide complete ordering. Sub-condition (1) is
> satisfied by pvops commit 43223efd9bfd.

I don't see this commit in Linus's tree, so I doubt it's valid for
me to apply this as a bug fix to my 'net' tree since the precondition
pvops commit isn't upstream as far as I can tell.

Where did you intend me to apply this patch, and how did you expect
the dependent commit to make it's way into the tree so that this
fix is complete?

BTW, you should always explicitly specificy the answers to all the
questions in the previous paragraph, otherwise (like right now) we
go back and forth wasting time establishing these facts.

The way to say which tree the patch is intended for is to specify
it in the Subject like, f.e. "[PATCH net-next v3 REPOST] ..."
