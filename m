From: Jidong Xiao <jidong.xiao@gmail.com>
Subject: How to measure time for program running in guest OS?
Date: Mon, 23 Jan 2012 23:09:08 -0500
Message-ID: <CAG4AFWaYdhP85ctnqPuOB0vN=r1_XjzJeK0Q+LBqe76Fm3Stpw@mail.gmail.com>
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

I am running a guest OS (Fedora 16) with kvm (The host is
OpenSuse11.3), and now I have a program running inside the guest OS
and I want to measure how long the program will run. The accuracy I
need is microsecond. Since we are in the virtualization environment, I
wonder how can we measure the time duration accurately. Can anyone
give me some suggestions, thank you!!

Regards
Jidong
