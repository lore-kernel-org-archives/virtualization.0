From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC 0/2] virtio: provide a way for host to monitor critical
	events in the device
Date: Wed, 25 Jul 2012 10:06:37 +0930
Message-ID: <87haswptgq.fsf@rustcorp.com.au>
References: <1343075561-29316-1-git-send-email-levinsasha928@gmail.com>
	<87a9yprc4v.fsf@rustcorp.com.au> <500E5C36.2070601@redhat.com>
	<500E954F.8090102@gmail.com> <500E9942.3080505@redhat.com>
	<500E9CC7.9020201@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <500E9CC7.9020201@gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sasha Levin <levinsasha928@gmail.com>, dlaor@redhat.com
Cc: Peter Maydell <peter.maydell@linaro.org>, wency@cn.fujitsu.com, kvm@vger.kernel.org, mst@redhat.com, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, penberg@kernel.org, avi@redhat.com, anthony@codemonkey.ws, Amit Shah <amit.shah@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 24 Jul 2012 15:01:59 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> virtio on it's own was introduced to help solve the fragmentation
> around virtualized devices, so I don't think that the main purpose of
> doing virtio drivers is due to any performance benefits virtio may
> provide.

There's one argument in your favor (with my Linaro hat on): ARM wants a
virtio reboot button, which would look remarkably similar.  There's no
standard ARM hardware for this.

So a more generalized virtio-event device might make sense.  But there
are almost an infinite number of guest events we might want: panics,
oom, low memory, stuck devices, deadlock, etc, etc.  I'm concerned about
trying to standardize them.  If we include a unspecified free-form
string, people will end up relying on the contents.  If we add a feature
bit for every new event, we'll end up running out of feature bits :)

CC'ing Amit for opinion over how much of this should be done via
virtio-serial.

Cheers,
Rusty.
