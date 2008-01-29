From: Anthony Liguori <aliguori@us.ibm.com>
Subject: Re: [PATCH] virtio_net tx performance fix
Date: Mon, 28 Jan 2008 22:09:48 -0600
Message-ID: <479EA70C.1080108@us.ibm.com>
References: <1201479224.3047.37.camel@localhost.localdomain>
	<479DF5A8.8050103@us.ibm.com>
	<1201535954.2457.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1201535954.2457.11.camel@localhost.localdomain>
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
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Dor Laor wrote:
> On Mon, 2008-01-28 at 09:32 -0600, Anthony Liguori wrote:
>   
>> Hi Dor,
>>
>> How are you measuring performance?  The numbers I've gotten with netperf 
>> before and after your patch are:
>>
>> tx - 647.27mbit
>> rx - 89.22
>>
>> tx - 27.82
>> rx - 79.93
>>
>>     
>
> I've been testing with iperf (patched with Ingo's fix).
> I also tested tcp/udp (udp tx is only 550Mbps with the patch, w/o it's
> only 220Mbps)
>   

FWIW, I repeated with an scp test copying a 200mb file from /dev/shm on 
the host to the guest and vice versa.  rx performance is around 3-4 
MB/sec.  Without your patch, tx performance is around 40 MB/sec whereas 
with your patch performance is around 30 MB/sec.  So the tx drop is 
definitely exaggerated by netperf.  I'm definitely not seeing an 
increase in throughput though.

Could you try a similar scp test?  What sort of networking setup are you 
using?

My guest kernel and host kernel are both 2.6.24 (from Ubuntu Hardy).

Regards,

Anthony Liguori
