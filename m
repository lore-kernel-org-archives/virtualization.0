From: Anthony Liguori <aliguori@us.ibm.com>
Subject: [PATCH 0/3] KVM paravirt_ops implementation
Date: Wed, 30 May 2007 09:49:39 -0500
Message-ID: <465D8F03.7000201@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: kvm-devel <kvm-devel@lists.sourceforge.net>
Cc: virtualization <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

This is the start of a paravirt_ops implementation for KVM.  Most of it 
was done by Ingo Molnar, I just moved things around a bit.  I don't 
think there's a measurable performance benefit just yet but there are a 
few more optimizations that I think we can get in time for 2.6.23 that 
will be measurable.

Regards,

Anthony Liguori
