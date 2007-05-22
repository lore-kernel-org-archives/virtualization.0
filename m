From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: changing definition of paravirt_ops.iret
Date: Tue, 22 May 2007 01:08:42 +0100
Message-ID: <4652348A.1020003@goop.org>
References: <4651C865.9090605@goop.org> <4651E6CF.9010001@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4651E6CF.9010001@vmware.com>
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
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> Strongly nacked.  If you need %fs and a free register, just push / pop
> them yourself.  We use push / pop to get %eax free for IRET in the VMI
> ROM. 

Yeah, it doesn't interact nicely with either the error_code or the nmi
stack switch thing.

    J
