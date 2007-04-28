From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 02:15:16 -0700
Message-ID: <463310A4.1050806@goop.org>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>	
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com>
	<4632FD3E.401@goop.org>	 <200704281042.48440.ak@suse.de>
	<1177751601.7646.58.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1177751601.7646.58.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: tglx@linutronix.de
Cc: James.Bottomley@hansenpartnership.com, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, "H. Peter Anvin" <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Thomas Gleixner wrote:
> Last test was 2.6.21-rc7, where I fixed the non-WP thing. The
> FP-emulator seems to work.
>
> Which kind of breakage is new ?
>   

We were just speculating about what breakage might exist.  If you've
been applying anti-entropy to  real 80386 machines, then I guess it
probably works better than I would have otherwise expected.

    J
