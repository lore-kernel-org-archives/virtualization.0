From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 09/16] map_switcher_in_guest() per-vcpu
Date: Wed, 26 Dec 2007 10:47:35 +1100
Message-ID: <200712261047.35810.rusty__49129.5293359601$1198626548$gmane$org@rustcorp.com.au>
References: <11981576363806-git-send-email-gcosta@redhat.com>
	<1198157678759-git-send-email-gcosta@redhat.com>
	<11981576833314-git-send-email-gcosta@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <11981576833314-git-send-email-gcosta@redhat.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Glauber de Oliveira Costa <gcosta@redhat.com>
Cc: lguest@ozlabs.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Friday 21 December 2007 00:33:49 Glauber de Oliveira Costa wrote:
> The switcher needs to be mapped per-vcpu, because different vcpus
> will potentially have different page tables (they don't have to,
> because threads will share the same).
>
> So our first step is the make the function receive a vcpu struct

Hmm, I wonder if we should call it lg_vcpu: lguest_vcpu is a little long, and 
in total adds a fair number of lines to the code :)

Rusty.
