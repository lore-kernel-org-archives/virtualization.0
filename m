From: Avi Kivity <avi@qumranet.com>
Subject: Re: [Lguest] networking in lguest: strange error: lguest: Guest	moved
	used index from 6 to 256
Date: Thu, 06 Mar 2008 12:45:26 +0200
Message-ID: <47CFCB46.7000300__17214.1578667381$1204800887$gmane$org@qumranet.com>
References: <1204560316.47cc21bc513ed@webmail.alinto.com>	
	<200803052206.31266.rusty@rustcorp.com.au>	
	<1204758239.4708.25.camel@localhost.localdomain>	
	<47CF2871.4070302@us.ibm.com>
	<1204759849.4708.36.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1204759849.4708.36.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: dor.laor@qumranet.com
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, Anthony Liguori <aliguori@us.ibm.com>, lguest@ozlabs.org, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> On Wed, 2008-03-05 at 17:10 -0600, Anthony Liguori wrote:
>   
>> Dor Laor wrote:
>>     
>>> Seems to work reliably with kvm, should do the same trick for lguest.
>>> You can download it from
>>> git://kvm.qumranet.com/home/dor/src/kvm-guest-drivers-linux
>>>
>>> Anthony, you can update your mercurial repository with our changes.
>>>   
>>>       
>> Hrm, I thought we were standardizing on 
>> http://www.kernel.org/pub/scm/virt/kvm/kvm-guest-drivers-linux.git
>>
>>     
>
> Better this way, attached 3 patches needed for compilation.
>
>   

Applied (as you saw), thanks -- but please, one patch per email next time.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
