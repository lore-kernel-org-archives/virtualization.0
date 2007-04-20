From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [RFC, PATCH 0/5] Paravirt: fix export of paravirt-ops to binary
 modules
Date: Fri, 20 Apr 2007 16:01:58 -0700
Message-ID: <46294666.90008@goop.org>
References: <20070420015214.6834BBFC@zach-dev2.vmware.com>
	<200704201134.42116.ak@suse.de> <4628D64A.4070900@goop.org>
	<46292FB2.5030404@vmware.com> <462931A2.2060104@goop.org>
	<46293266.9020306@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46293266.9020306@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: Andrew Morton <akpm@osdl.org>, Petr Vandrovec <petr@vmware.com>, Chaz Masden <zamsden@gmail.com>, virtualization@lists.linux-foundation.org, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Nope.  But I think we should maintain parity between PAE and non-PAE -
> and probably also maintain parity between non-paravirt-ops and
> paravirt-ops, which means the 5 arg macros are a good idea.  It's not
> like they are very hard to create or maintain. 

Yep.  Did you see the comment about not being able to use "rm" for arg4?

    J
