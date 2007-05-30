From: Zachary Amsden <zach@vmware.com>
Subject: Re: [kvm-devel] [PATCH 3/3] Eliminate read_cr3 on TLB flush
Date: Wed, 30 May 2007 14:49:03 -0700
Message-ID: <465DF14F.4020709__3596.75919539786$1180562209$gmane$org@vmware.com>
References: <97D612E30E1F88419025B06CB4CF1BE10259AD95@scsmsx412.amr.corp.intel.com>
	<465DCED8.4080506@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <465DCED8.4080506@us.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Anthony Liguori <aliguori@us.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:
>
> I was thinking the same thing :-)
>
> I was actually thinking about adding a hypercall to set/clear a bit in 
> a control register.  The thought here is that it would be useful not 
> just for the global bit but also for CR0.TS although we would need 
> another paravirt_op hook for stts.

You don't need STTS: just cache CR0 value on writes and replace 
read_cr0.  More paravirt_op hooks would likely be frowned upon, we've 
already got too many.

Zach
