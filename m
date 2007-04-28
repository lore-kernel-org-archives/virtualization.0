From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: huh startup_ipi_hook?
Date: Sat, 28 Apr 2007 01:59:55 -0700
Message-ID: <46330D0B.9000303@goop.org>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>	<4632F653.3000102@goop.org>
	<m14pn0hqij.fsf@ebiederm.dsl.xmission.com>	<4633051A.3000200@goop.org>
	<m1vefgga9b.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1vefgga9b.fsf@ebiederm.dsl.xmission.com>
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

Eric W. Biederman wrote:
> I was thinking of our magic process specific vectors and those
> aren't quite IPIs.  But there are some other uses to add to your list
> but not necessarily in general we have irq migration, irq
> retransmission, sending NMIs to shootdown cpus.
>   

Yes, but I see those as implementation details. In Xen I don't think we
need IPIs for any of those. If a particular implementation needs IPIs
then its free to use them.

> What I don't understand is how do we map MSI's to event channels.
> That is going to be an interesting one.  Because the drivers in
> essence decide how many of those the hardware will have.
>   

That's an interesting point. I haven't really looked at giving domains
direct hardware access. Its not something which makes much sense without
a good IOMMU anyway.

> I'm a little interested in that as well.  It would be good to have a
> common place for the shared code.  Although I wonder if it is only
> arch/i386 and arch/x86_64 that need to be in the discussion.
> arch/ia64 has some significant pieces of shared heritage.  Although
> nowhere near as much.
>   

Well, if i386 and x86_64 make it look like fun, I'm sure ia64 will work
out how to come to the party.


>> Yes, and its tricky in places to have a single interface which is
>> supposed to deal with both Xen and VMI, since they're often at opposite
>> ends of the abstraction spectrum. So we end up with a high-level
>> interface which calls into Xen code and the existing native code, and
>> then some hooks in the native code to call out to Xen. If the native
>>     
s/Xen/VMI/


J
