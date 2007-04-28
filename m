From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: The virtuailization patches break Voyager.
Date: Sat, 28 Apr 2007 10:07:51 -0700
Message-ID: <46337F67.2020804@zytor.com>
References: <m1mz0tgfxa.fsf@ebiederm.dsl.xmission.com>	<4632F0E5.1060508@goop.org>
	<m18xcdgdus.fsf@ebiederm.dsl.xmission.com>	<4632FD3E.401@goop.org>
	<4633791A.4040100@zytor.com>
	<m1vefge8nl.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1vefge8nl.fsf@ebiederm.dsl.xmission.com>
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
Cc: James.Bottomley@HansenPartnership.com, virtualization@lists.osdl.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
>>
>> Incidentally, the rewrite is looking very promising so far.  Apparently
>> there is tons of odd or just plain dead code lurking in setup.S.
> 
> Just send it out for review before we merge it.
> 
> We don't want to break things like loadlin support if we don't have to.
> 
> If figure worse case we can convert your clean up back into assembly
> and have a more readable and maintainable setup.S :)
> 

It doesn't look like there should be a problem getting the loadlin hooks
to continue working.  Something else that might be useful to know is if
there are pre-2.02 bootloaders that are still being used (other than
loadlin?)

As the patches I have now I'm breaking support for pre-2.00 bootloaders,
which don't have bzImage support anyway and thus, I think, can be
disregarded as historic.

	-hpa
