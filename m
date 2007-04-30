From: Zachary Amsden <zach@vmware.com>
Subject: Re: huh startup_ipi_hook?
Date: Mon, 30 Apr 2007 14:40:49 -0700
Message-ID: <46366261.3070901@vmware.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<4632F653.3000102@goop.org> <46363662.40806@vmware.com>
	<46363B5D.7060101@goop.org> <463652FE.9080604@vmware.com>
	<46365A0F.9040901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46365A0F.9040901@goop.org>
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
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I think the more things we can devolve out of paravirt_ops the better,
> especially if they make well-defined self-contained interfaces of their
> own.  I would be open, for example, to moving all the pagetable and
> privileged instruction operations out into their own _ops interfaces
> (but not right now).
>   

I think this trend of moving things into smaller compact interfaces is 
the right way to go, and certainly the apic stuff can devolve, as well 
as privileged / pagetable ops.  We can target that for .23, and it would 
go quite a ways towards giving a better foundation for x86_64 (even 
non-x86) paravirt to build on.

Zach
