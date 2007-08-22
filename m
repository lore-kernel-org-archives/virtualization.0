From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [PATCH] Add I/O hypercalls for i386 paravirt
Date: Wed, 22 Aug 2007 23:15:11 +0100
Message-ID: <46CCB56F.8090308@superbug.co.uk>
References: <46CBC842.4070100@vmware.com> <46CCB088.8070606@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <46CCB088.8070606@goop.org>
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
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Zachary Amsden wrote:
>> This patch provides hypercalls for the i386 port I/O instructions,
>> which vastly helps guests which use native-style drivers.  For certain
>> VMI workloads, this provides a performance boost of up to 30%.  We
>> expect KVM and lguest to be able to achieve similar gains on I/O
>> intensive workloads.
> 
> Two comments:
> 
> - I should dust off my "break up paravirt_ops" patch, and this would fit
> nicely into it (I think we already discussed this)
> 
> - What happens if you *don't* want to pv some of the io instructions? 
> What if you have a device which is directly exposed to the guest?


If one could directly expose a device to the guest, this feature could
be extremely useful for me.
Is it possible? How would it manage to handle the DMA bus mastering?

James
