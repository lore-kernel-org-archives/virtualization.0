From: Avi Kivity <avi@qumranet.com>
Subject: Re: [kvm-devel] [PATCH 00/10] PV-IO v3
Date: Mon, 20 Aug 2007 17:14:03 +0300
Message-ID: <46C9A1AB.7090008__30861.145273275$1187619343$gmane$org@qumranet.com>
References: <20070816231357.8044.55943.stgit@ghaskins-t60p.haskins.net>	
	<1187313953.6449.70.camel@localhost.localdomain>	
	<46C80C5B.7070009@qumranet.com>
	<1187617806.4363.179.camel@ghaskins-t60p.haskins.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1187617806.4363.179.camel@ghaskins-t60p.haskins.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <ghaskins@novell.com>
Cc: kvm-devel@lists.sourceforge.net, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Gregory Haskins wrote:
>>>   
>>>       
>> Or, my preference, have a small sglist in the descriptor;
>>     
>
>
> Define "small" ;)
>   

4.

> There a certainly patterns that cannot/will-not take advantage of SG
> (for instance, your typical network rx path), and therefore the sg
> entries are wasted in some cases.  Since they need to be (IMHO) u64,
> they suck down at least 8 bytes a piece.  Because of this I elected to
> use the model of one pointer per descriptor, with an external descriptor
> for SG.  What are your thoughts on this?
>   

Measurement will tell.  I have a feeling that it won't really matter, so 
maybe an external sglist is best.

-- 
error compiling committee.c: too many arguments to function
