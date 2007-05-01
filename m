From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [patches] [PATCH] [21/22] x86_64: Extend bzImage protocol for
 relocatable bzImage
Date: Mon, 30 Apr 2007 19:48:53 -0700
Message-ID: <4636AA95.3090204@zytor.com>
References: <20070428175909.1D09D151CA@wotan.suse.de>
	<46338D72.70402@garzik.org>
	<m1fy6kdzi1.fsf@ebiederm.dsl.xmission.com>
	<4634483E.9030307@goop.org>
	<m14pmz8bbb.fsf@ebiederm.dsl.xmission.com>
	<46363A68.6080201@goop.org>
	<m18xc9344o.fsf@ebiederm.dsl.xmission.com>
	<463670D1.3000003@goop.org>
	<m14pmx31bw.fsf@ebiederm.dsl.xmission.com>
	<463678BA.5080609@zytor.com>
	<20070501033931.GI25929@bingen.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070501033931.GI25929@bingen.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andi Kleen <ak@suse.de>
Cc: Jeff Garzik <jeff@garzik.org>, patches@x86-64.org, linux-kernel@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>, Vivek Goyal <vgoyal@in.ibm.com>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Andi Kleen wrote:
> 
> It's still unclear to me why exactly you want to rewrite it?
> Are there any particular bugs in the current code you want to fix?
> 

It's more the sheer degree of unmaintainability which is grating on my
nerves.  There is way too much hocus-pocus going on, and I dare to say
that probably noone understands what actually happens in there.

In response to the question about what the code looks like, I have put a
development snapshot patch at:

http://userweb.kernel.org/~hpa/setup-snapshot-2007.04.30.patch

Note that it compiles, but it doesn't work yet.  This is not a
submission, just a "what does the code actually look like" sample.

	-hpa
