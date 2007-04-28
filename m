From: Andi Kleen <ak@suse.de>
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 10:45:11 +0200
Message-ID: <200704281045.11461.ak@suse.de>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
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
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org


> 
> I think we should be intercepting this startup call at a higher level,
> where we can just say:  Start secondary cpu with this stack
> and with this esp.  Or something like that.

The reason VMI tends to thing lower level is that most of its 
interfaces are like real hardware and of the code
would be just copied then if it did high level interfaces.

I suspect this specific hook could only be made better if 
smpboot.c was refactored into more pieces and callable, but I doubt
that would be a big overall improvement.

-Andi
