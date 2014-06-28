From: Jimmy Thrasibule <thrasibule.jimmy@gmail.com>
Subject: Virtualized desktop
Date: Sat, 28 Jun 2014 12:10:18 +0200
Message-ID: <CAMqSRmDFNGV9rM68FpRuxov2jGXFMvmt28=Hici9PU_DNaFuzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Hi,

I'm looking to renew my hardware and I'm wondering how Linux can help
me to virtualize my desktop environment.

My first go was to have 2 Intel NUC and 2 screens, one NUC more stable
and one I can play with. I want to use both screens with both
computers so this implies to also have two KVMs.

Then came the idea to virtualize everything. Make both computers a
hypervisor cluster (using Xen or KVM) and run all systems virtualized.
But at which point can this be done for desktop system?


Here are some points I'm blocking with:

1. I want two screens and be able take make each VM to use one (left
or right) or both screens. Maybe by pressing some keyboard shortcuts.

2. I want mouse a keyboard to be moved to the VM of my choice or
dedicated to one VM and use Synergy [1] for the others.

3. I will have somewhere a Windows VM so good support is needed.

4. What about the graphics? Can I still make use of Blender for
example? How the graphic card shared between each VM?

5. I'd like to make both hypervisor work together. Can I use the local
drive of each computer to ensure migration and folder sharing?


I see many advantages which this setup:

1. I can freely test, new VM and we are done.
2. I can make a snapshot at any time just in case and go back if my
system crashes.

And some drawbacks:

1. I will never have full performance of my hardware.


Is it for you something that can be done or no way?


[1] http://synergy-project.org/
