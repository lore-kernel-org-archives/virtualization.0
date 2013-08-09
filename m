From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH  V12 0/14] Paravirtualized ticket spinlocks
Date: Fri, 9 Aug 2013 09:00:15 -0400
Message-ID: <20130809130015.GA3730@phenom.dumpdata.com>
References: <20130806114020.20643.57235.sendpatchset@codeblue.in.ibm.com>
	<52016412.1020608@zytor.com> <5201B6FB.5080807@linux.vnet.ibm.com>
	<5201D180.9080005@zytor.com> <5201ED01.7000803@linux.vnet.ibm.com>
	<20130808005012.GI2810@phenom.dumpdata.com>
	<20130808010251.GJ15901@redhat.com> <52040A05.5080107@zytor.com>
	<520423E9.80507@zytor.com> <5204E57A.3000002@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5204E57A.3000002@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Cc: jeremy@goop.org, gregkh@suse.de, kvm@vger.kernel.org, linux-doc@vger.kernel.org, peterz@infradead.org, drjones@redhat.com, virtualization@lists.linux-foundation.org, andi@firstfloor.org, "H. Peter Anvin" <hpa@zytor.com>, xen-devel@lists.xensource.com, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, stefano.stabellini@eu.citrix.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 09, 2013 at 06:20:02PM +0530, Raghavendra K T wrote:
> On 08/09/2013 04:34 AM, H. Peter Anvin wrote:
> >
> >Okay, I figured it out.
> >
> >One of several problems with the formatting of this patchset is that it
> >has one- and two-digit patch numbers in the headers, which meant that my
> >scripts tried to apply patch 10 first.
> >
> 
> My bad. I 'll send out in uniform digit form next time.
> 

If you use 'git format-patch --subject-prefix "PATCH V14" v3.11-rc4..'
and 'git send-email --subject "[PATCH V14] bla blah" ..'
that should be automatically taken care of?
