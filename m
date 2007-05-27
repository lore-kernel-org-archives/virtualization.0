From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Extending boot protocol & bzImage for paravirt_ops
Date: Sat, 26 May 2007 17:15:54 -0700
Message-ID: <4658CDBA.5000603@zytor.com>
References: <4656FB8F.4090604@goop.org>	
	<m14pm0c0m2.fsf@ebiederm.dsl.xmission.com>	
	<1180174691.650.8.camel@localhost.localdomain>
	<4658C72E.9030205@goop.org>
	<1180224604.29340.4.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1180224604.29340.4.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> 
> hpa wrote:
>> Do we have *any* environment that enters the 32-bit code with interrupts
>> enabled?  I would think that is unsafe no matter how you do it.
> 
> Yeah, the cli there seems strange: maybe it's safe to simply delete it?
> 

I suspect it was simply put there as a "belts and suspenders" kind of
thing, which is perfectly appropriate.  However, I would be highly
surprised if it would have any users.

	-hpa
