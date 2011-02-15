From: Michal Hocko <mhocko@suse.cz>
Subject: Re: [PATCH] virtio: use __GFP_NOWARN for try_fill_recv in virtnet_poll
Date: Tue, 15 Feb 2011 13:39:36 +0100
Message-ID: <20110215123936.GE8341__15447.1074384221$1297931182$gmane$org@tiehlicka.suse.cz>
References: <20110215093527.GB8341@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110215093527.GB8341@tiehlicka.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Tue 15-02-11 10:35:27, Michal Hocko wrote:
[...]
> [22798.508903] The following is only an harmless informational message.
> [22798.508909] Unless you get a _continuous_flood_ of these messages it means
> [22798.508911] everything is working fine. Allocations from irqs cannot be
> [22798.508913] perfectly reliable and the kernel is designed to handle that.

I have just realized that the above text is SLES specific so only the
line below with stack trace and memory info is printed. Sorry for confusion

> [22798.508917] loop3: page allocation failure. order:0, mode:0x20, alloc_flags:0x30 pflags:0x80208040

-- 
Michal Hocko
SUSE Labs
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
