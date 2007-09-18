From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 3/3] Time to make CONFIG_PARAVIRT non-experimental.
Date: Tue, 18 Sep 2007 12:57:41 +0200
Message-ID: <200709181257.41530.ak__1019.84074940464$1190113311$gmane$org@suse.de>
References: <1189747054.7262.34.camel@localhost.localdomain>
	<1189747124.7262.36.camel@localhost.localdomain>
	<1189747280.7262.39.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1189747280.7262.39.camel@localhost.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
Cc: Chris Wright <chrisw@sous-sol.org>, Anthony Liguori <aliguori@us.ibm.com>, lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On Friday 14 September 2007 07:21, Rusty Russell wrote:
> It's pretty widely used,

Is it? By whom?

> and the distributions will turn it on. 

That's no reason to make it default y. Please undo that. default y
is near always a bad idea.

Also I would still consider it experimental.

-Andi
