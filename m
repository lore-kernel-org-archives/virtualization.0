From: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
Subject: Re: [PATCH RFC V10 0/18] Paravirtualized ticket spinlocks
Date: Wed, 26 Jun 2013 14:03:40 +0530
Message-ID: <51CAA764.7000006@linux.vnet.ibm.com>
References: <20130624124014.27508.8906.sendpatchset@codeblue.in.ibm.com>
	<20130624131716.GA11948@hawk.usersys.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20130624131716.GA11948@hawk.usersys.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Andrew Jones <drjones@redhat.com>
Cc: jeremy@goop.org, gregkh@suse.de, linux-doc@vger.kernel.org, peterz@infradead.org, virtualization@lists.linux-foundation.org, andi@firstfloor.org, hpa@zytor.com, stefano.stabellini@eu.citrix.com, xen-devel@lists.xensource.com, kvm@vger.kernel.org, x86@kernel.org, mingo@redhat.com, habanero@linux.vnet.ibm.com, riel@redhat.com, konrad.wilk@oracle.com, ouyang@cs.pitt.edu, avi.kivity@gmail.com, tglx@linutronix.de, chegu_vinod@hp.com, linux-kernel@vger.kernel.org, srivatsa.vaddagiri@gmail.com, attilio.rao@citrix.com, pbonzini@redhat.com, torvalds@linux-foundation.org, stephan.diestelhorst@amd.com
List-Id: virtualization@lists.linuxfoundation.org

On 06/24/2013 06:47 PM, Andrew Jones wrote:
> On Mon, Jun 24, 2013 at 06:10:14PM +0530, Raghavendra K T wrote:
>>
>> Results:
>> =======
>> base = 3.10-rc2 kernel
>> patched = base + this series
>>
>> The test was on 32 core (model: Intel(R) Xeon(R) CPU X7560) HT disabled
>> with 32 KVM guest vcpu 8GB RAM.
>
> Have you ever tried to get results with HT enabled?
>
>>
>> +-----------+-----------+-----------+------------+-----------+
>>                 ebizzy (records/sec) higher is better
>> +-----------+-----------+-----------+------------+-----------+
>>      base        stdev        patched    stdev        %improvement
>> +-----------+-----------+-----------+------------+-----------+
>> 1x  5574.9000   237.4997    5618.0000    94.0366     0.77311
>> 2x  2741.5000   561.3090    3332.0000   102.4738    21.53930
>> 3x  2146.2500   216.7718    2302.3333    76.3870     7.27237
>> 4x  1663.0000   141.9235    1753.7500    83.5220     5.45701
>> +-----------+-----------+-----------+------------+-----------+
>
> This looks good. Are your ebizzy results consistent run to run
> though?
>
>> +-----------+-----------+-----------+------------+-----------+
>>                dbench  (Throughput) higher is better
>> +-----------+-----------+-----------+------------+-----------+
>>      base        stdev        patched    stdev        %improvement
>> +-----------+-----------+-----------+------------+-----------+
>> 1x 14111.5600   754.4525   14645.9900   114.3087     3.78718
>> 2x  2481.6270    71.2665    2667.1280    73.8193     7.47498
>> 3x  1510.2483    31.8634    1503.8792    36.0777    -0.42173
>> 4x  1029.4875    16.9166    1039.7069    43.8840     0.99267
>> +-----------+-----------+-----------+------------+-----------+
>
> Hmm, I wonder what 2.5x looks like. Also, the 3% improvement with
> no overcommit is interesting. What's happening there? It makes
> me wonder what < 1x looks like.
>

Hi Andrew,

I tried 2.5x case sort where I used 3 guests with 27 vcpu each on 32
core (HT disabled machine) and here is the output. almost no gain there.

              throughput avg    stdev
base:     1768.7458 MB/sec     54.044221
patched:  1772.5617 MB/sec     41.227689
gain %0.226

I am yet to try HT enabled cases that would give 0.5x to 2x performance
results.
