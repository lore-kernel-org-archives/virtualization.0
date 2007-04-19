From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
	mappings
Date: Thu, 19 Apr 2007 22:50:52 +0200
Message-ID: <200704192250.52633.ak@suse.de>
References: <20070414204154.871250608@goop.org>
	<20070414204924.125386443@goop.org> <4627D57C.4070809@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4627D57C.4070809@redhat.com>
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
To: Chuck Ebbert <cebbert@redhat.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org


> 
> Is some version of this going in for 2.6.21, or is it not a real problem?

When it's only seen with Xen it's not a real problem right now.

-Andi
