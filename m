From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 09:40:58 -0700
Message-ID: <4633791A.4040100@zytor.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>	<4632F0E5.1060508@goop.org>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com> <4632FD3E.401@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632FD3E.401@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Eric W. Biederman wrote:
>> Next time I'm in a really tormenting mood I will fire up my 
>> my ibm ps2 with it's 16Mhz 386 and 6MB and verify that all is working
>> well there.  
> 
> Well, that would be interesting. From a subarch perspective, it would
> just be the normal default, and in theory it should work fine. But I
> suspect the fpu emulator is probably broken, and non-WP is likely to
> have rotted, and lots of other things. Is that an MCA machine?

Heh.  I actually have a Voyager sitting in the garage.  I've never
plugged it in or turned it on, but after this thread I'm wondering if my
rewrite of the setup code will have to entail dragging it in and trying
to boot it (please, no...) :)

Incidentally, the rewrite is looking very promising so far.  Apparently
there is tons of odd or just plain dead code lurking in setup.S.

	-hpa
