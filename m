From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 10/28] i386: map enough initial memory to create lowmem
 mappings
Date: Mon, 23 Apr 2007 13:41:38 -0700
Message-ID: <462D1A02.5060403@zytor.com>
References: <20070414204154.871250608@goop.org>	<200704192250.52633.ak@suse.de>
	<4627D756.5020405@zytor.com>	<200704192304.01053.ak@suse.de>
	<4627DB0C.2010804@zytor.com>	<4627DDAD.4070805@redhat.com>
	<4627E099.209@goop.org>	<m1d51vxxm4.fsf@ebiederm.dsl.xmission.com>
	<462CE027.4030302@goop.org>	<462CE1E0.9060007@zytor.com>	<m1zm4zvwfr.fsf@ebiederm.dsl.xmission.com>	<462CF5B8.4070708@xensource.com>	<m1y7kivs3s.fsf@ebiederm.dsl.xmission.com>
	<462D04B2.6080008@goop.org>	<462D05A0.1020100@zytor.com>
	<462D072F.6030809@goop.org>
	<m1r6qavq0y.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1r6qavq0y.fsf@ebiederm.dsl.xmission.com>
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
Cc: lkml <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Chuck Ebbert <cebbert@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Eric W. Biederman wrote:
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
> 
>> H. Peter Anvin wrote:
>>> It would be *trivial* to make a certain number of page table slots
>>> available at the end of the head.S-generated map. 
>> Or you could use a fixmap.
> 
> That certain number of page table slots should be the fixmap slots.
> If you do that bt_ioremap works, we remove a boatload of special cases
> and the code becomes simpler.

It's probably worth noting that several of the non-PC ports already do 
exactly this, although in a hacky way.  Grep for pg0 and you'll find it.

	-hpa
