From: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
	mappings
Date: Thu, 19 Apr 2007 23:04:00 +0200
Message-ID: <200704192304.01053.ak@suse.de>
References: <20070414204154.871250608@goop.org>
	<200704192250.52633.ak@suse.de> <4627D756.5020405@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4627D756.5020405@zytor.com>
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
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Thursday 19 April 2007 22:55:50 H. Peter Anvin wrote:
> Andi Kleen wrote:
> >> Is some version of this going in for 2.6.21, or is it not a real problem?
> > 
> > When it's only seen with Xen it's not a real problem right now.
> 
> It's not just seen only with Xen, though.  It will affect all kernels in 
> a particular range of sizes, and we have ordinary kernels covering that 
> range (in fact, Xen hardly affects size in that way.)

Then we would have seen reports surely?

-Andi
