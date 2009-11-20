From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] Replace kvm io delay pv-ops with linux magic
Date: Fri, 20 Nov 2009 09:54:05 +0800
Message-ID: <4B05F6BD.3050402__25437.1729949073$1258682476$gmane$org@goop.org>
References: <1258548984-32433-1-git-send-email-agraf@suse.de>
	<4B05CCEB.5050802@goop.org>
	<9466A245-8DB5-40FB-AE94-168117C2C692@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <9466A245-8DB5-40FB-AE94-168117C2C692@suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Alexander Graf <agraf@suse.de>
Cc: Nick Piggin <npiggin@suse.de>, kvm list <kvm@vger.kernel.org>, Glauber Costa <glommer@redhat.com>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>, Avi Kivity <avi@redhat.com>, Alok Kataria <akataria@vmware.com>
List-Id: virtualization@lists.linuxfoundation.org

On 11/20/09 07:58, Alexander Graf wrote:
>
> Am 19.11.2009 um 23:55 schrieb Jeremy Fitzhardinge <jeremy@goop.org>:
>
>> On 11/18/09 20:56, Alexander Graf wrote:
>>> Currently we use pv-ops to tell linux not to do anything on io_delay.
>>>
>>> While the basic idea is good IMHO, I don't see why we would need pv-ops
>>> for that. The io delay function already has a switch that can do
>>> nothing
>>> if you're so inclined.
>>>
>>> So here's a patch (stacked on top of the previous pv-ops series) that
>>> removes the io delay pv-ops hook and just sets the native io delay
>>> variable instead.
>>>
>>
>> Can you just get rid of the io_delay op altogether?  If KVM doesn't need
>> it, then nobody does.
>
> Sure, can do. That'd be a separate patch though.

Yep.  A patch each for VMI and Xen to remove the dependency, and a final
patch to remove the op.  Hm, looks like VMI has a specific ROM call for
io_delay; I wonder what it does.

    J
