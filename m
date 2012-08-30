From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH v2 2/2] virtio-ring: Allocate indirect buffers from cache
	when possible
Date: Thu, 30 Aug 2012 12:34:07 +0200
Message-ID: <503F419F.5040800@gmail.com>
References: <1346159043-16446-1-git-send-email-levinsasha928@gmail.com>
	<1346159043-16446-2-git-send-email-levinsasha928@gmail.com>
	<20120828132032.GB2039@redhat.com> <503CC904.3050207@gmail.com>
	<20120829110748.GB5970@redhat.com> <503E2F27.5060904@gmail.com>
	<20120829151445.GC7407@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120829151445.GC7407@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: avi@redhat.com, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On 08/29/2012 05:14 PM, Michael S. Tsirkin wrote:
>> > Note that these are simple tests with netperf listening on one end and a simple
>> > 'netperf -H [host]' within the guest. If there are other tests which may be
>> > interesting please let me know.
> Checking that host CPU utilization did not jump would be nice.
> E.g. measure BW/host CPU.

Tested it now, no change in CPU between the original, patch 1 and patch 2.


Thanks,
Sasha
