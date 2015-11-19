From: Sasha Levin <sasha.levin@oracle.com>
Subject: Re: [RFC] kvmtool: add support for modern virtio-pci
Date: Thu, 19 Nov 2015 08:41:12 -0500
Message-ID: <564DD178.9010904@oracle.com>
References: <1447823472-17047-1-git-send-email-sasha.levin@oracle.com>
	<1447834972.23726.92.camel@redhat.com> <564C9805.8080800@oracle.com>
	<1447869140.23691.15.camel@redhat.com> <564D496D.2010105@oracle.com>
	<564D49A7.30400@oracle.com> <1447917670.25140.3.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1447917670.25140.3.camel@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: kvm@vger.kernel.org, mst@redhat.com, andre.przywara@arm.com, will.deacon@arm.com, josh@joshtriplett.org, virtualization@lists.linux-foundation.org, penberg@kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On 11/19/2015 02:21 AM, Gerd Hoffmann wrote:
> On Mi, 2015-11-18 at 23:01 -0500, Sasha Levin wrote:
>> On 11/18/2015 11:00 PM, Sasha Levin wrote:
>>> Anyways, I debugged it for a bit a found that seabios attempts to write to
>>> the notification BAR, I look further tomorrow to narrow it down and fix it.
>>
>> Err, *read*, obviously.
>>
>> I've never implemented that because the kernel doesn't try to do that (it doesn't
>> make much sense, I think...).
> 
> It doesn't make sense indeed (kvmtool still shouldn't segfault though),
> and on a quick look I can't spot a place in seabios doing that ...
> 
> It's reading ISR, as part of device reset, to make sure any pending
> interrupts are cleared.

That was indeed the ISR field. Fixing that makes seabios reach the same point as
legacy virtio before failing.

I don't see the original correspondence about seabios failures you've reported, if
you want to forward them over we can look at it further.


Thanks,
Sasha
