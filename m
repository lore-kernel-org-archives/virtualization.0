From: Vincent JARDIN <vincent.jardin@6wind.com>
Subject: Re: Using virtio for inter-VM communication
Date: Thu, 12 Jun 2014 11:31:12 +0200
Message-ID: <53997360.3070307__42912.7399264418$1402565493$gmane$org@6wind.com>
References: <20140610184818.2e490419@nbschild1> <53978375.6090707@6wind.com>
	<87ppie1v4r.fsf@blackfin.pond.sub.org>
	<20140612094413.15e56938@nbschild1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20140612094413.15e56938@nbschild1>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Henning Schild <henning.schild@siemens.com>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 12/06/2014 09:44, Henning Schild wrote:
>> It may be used, but that doesn't mean it's maintained, or robust
>> >against abuse.  My advice is to steer clear of it.
> Could you elaborate on why you advice against it?

+1 elaborate please.

beside the DPDK source code, some other common use cases:
   - HPC: using inter VM shared memory for ultra low latency inter VM 
computation

Best regards,
   Vincent
