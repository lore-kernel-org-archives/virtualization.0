From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 00/10] virtio: console: fixes for races with port unplug
Date: Fri, 19 Jul 2013 10:33:50 +0530
Message-ID: <20130719050350.GB3087@amit-x200.redhat.com>
References: <cover.1374177234.git.amit.shah@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <cover.1374177234.git.amit.shah@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 19 Jul 2013 [01:46:07], Amit Shah wrote:
> Hello,
> 
> This series fixes a few races with port unplug and the various file
> operations: read(), write(), close() and poll().
> 
> There still might be more races lurking, but testing this series looks
> good to at least solve the easily-triggerable ones.  I've run the
> virtio-serial testsuite and a few open/close/unplug tests, and haven't
> seen any badness.
> 
> I've marked these patches for stable@ as well.  I went over the list
> twice to check if really each one should go to stable, and to me it
> looks like all are stable candidates.

Ah - I forgot CC: stable in patch 6 onwards.  I'll post a v2 with
those included, but will wait for review comments for a couple of
days.

		Amit
